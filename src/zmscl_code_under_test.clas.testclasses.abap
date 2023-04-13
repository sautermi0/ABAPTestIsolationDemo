CLASS ltd_depended_on_component DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES zmsif_depended_on_component PARTIALLY IMPLEMENTED.

    DATA m_result TYPE i.

ENDCLASS.

CLASS ltd_depended_on_component IMPLEMENTATION.
  METHOD zmsif_depended_on_component~add.
    r_sum = m_result.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_call_other_object DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup                    RAISING cx_static_check.
    METHODS double_with_framework    FOR TESTING RAISING cx_static_check.
    METHODS double_without_framework FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_call_other_object IMPLEMENTATION.
  METHOD setup.
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD double_with_framework.
    " ABAP Object Oriented Test Double Framework
    " Given
    FINAL(test_double) = CAST zmsif_depended_on_component( cl_abap_testdouble=>create( 'zmsif_depended_on_component' ) ).

    cl_abap_testdouble=>configure_call( test_double )->returning( 1 ).

    test_double->add( i_summand_1 = 1
                      i_summand_2 = 2 ).

    zmsth_injector=>inject_depended_on_component( test_double ).

    " When
    FINAL(result) = m_cut->call_other_object( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 1 ).
  ENDMETHOD.

  METHOD double_without_framework.
    " Selbstgebauter Test Double
    " Given
    FINAL(test_double) = NEW ltd_depended_on_component( ).
    test_double->m_result = 2.
    zmsth_injector=>inject_depended_on_component( test_double ).

    " When
    FINAL(result) = m_cut->call_other_object( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 2 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_call_function_module DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA g_function_test_environment TYPE REF TO if_function_test_environment.

    CLASS-METHODS class_setup.

    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup                RAISING cx_static_check.
    METHODS fm_answer_1_expect_1 FOR TESTING RAISING cx_static_check.
    METHODS fm_answer_2_expect_2 FOR TESTING RAISING cx_static_check.
    METHODS fm_answer_a_expect_a FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_call_function_module IMPLEMENTATION.
  METHOD class_setup.
    " Function Module Test Double Framework
    g_function_test_environment = cl_function_test_environment=>create(
                                                                        VALUE #( ( 'POPUP_TO_CONFIRM' ) ) ).
  ENDMETHOD.

  METHOD setup.
    g_function_test_environment->clear_doubles( ).
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD fm_answer_1_expect_1.
    " Given
    FINAL(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    FINAL(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 1 ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    FINAL(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 1 ).
  ENDMETHOD.

  METHOD fm_answer_2_expect_2.
    " Given
    FINAL(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    FINAL(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 2 ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    FINAL(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 2 ).
  ENDMETHOD.

  METHOD fm_answer_a_expect_a.
    " Given
    FINAL(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    FINAL(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 'A' ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    FINAL(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 'A' ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_select_database_table DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES t_demo_sales_so_i TYPE STANDARD TABLE OF demo_sales_so_i WITH DEFAULT KEY.

    CLASS-DATA g_sql_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup       RAISING cx_static_check.
    METHODS aggregation FOR TESTING RAISING cx_static_check.
    METHODS empty_table FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_select_database_table IMPLEMENTATION.
  METHOD class_setup.
    " ABAP SQL Test Double Framework
    g_sql_environment = cl_osql_test_environment=>create( VALUE #( ( 'DEMO_SALES_SO_I' ) ) ).
  ENDMETHOD.

  METHOD class_teardown.
    g_sql_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    g_sql_environment->clear_doubles( ).
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD aggregation.
    " Given
    g_sql_environment->insert_test_data(
        VALUE t_demo_sales_so_i( ( so_item_key = '11' parent_key  = '1' )
                                 ( so_item_key = '12' parent_key  = '1' )
                                 ( so_item_key = '13' parent_key  = '1' )
                                 ( so_item_key = '21' parent_key  = '2' )
                                 ( so_item_key = '31' parent_key  = '3' ) ) ).

    " When
    FINAL(result) = m_cut->select_database_table( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = lines( result )
                                        exp = 3 ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '1'
                                                                    ItemCount  = 3 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '2'
                                                                    ItemCount  = 1 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '3'
                                                                    ItemCount  = 1 ] ) ) ).
  ENDMETHOD.

  METHOD empty_table.
    " When
    FINAL(result) = m_cut->select_database_table( ).

    " Then
    cl_abap_unit_assert=>assert_initial( result ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_select_cds_entity DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES t_demo_sales_so_i TYPE STANDARD TABLE OF demo_sales_so_i WITH DEFAULT KEY.

    CLASS-DATA g_cds_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup       RAISING cx_static_check.
    METHODS aggregation FOR TESTING RAISING cx_static_check.
    METHODS empty_table FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_select_cds_entity IMPLEMENTATION.
  METHOD class_setup.
    " ABAP CDS Test Double Framework
    g_cds_environment = cl_cds_test_environment=>create( 'ZMS_CDS_ENTITY' ).
  ENDMETHOD.

  METHOD class_teardown.
    g_cds_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    g_cds_environment->clear_doubles( ).
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD aggregation.
    " Given
    g_cds_environment->insert_test_data(
        VALUE t_demo_sales_so_i( ( so_item_key = '11' parent_key  = '1' )
                                 ( so_item_key = '12' parent_key  = '1' )
                                 ( so_item_key = '13' parent_key  = '1' )
                                 ( so_item_key = '21' parent_key  = '2' )
                                 ( so_item_key = '31' parent_key  = '3' ) ) ).

    " When
    FINAL(result) = m_cut->select_cds_entity( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = lines( result )
                                        exp = 3 ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '1'
                                                                    ItemCount  = 3 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '2'
                                                                    ItemCount  = 1 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ SalesOrder = '3'
                                                                    ItemCount  = 1 ] ) ) ).
  ENDMETHOD.

  METHOD empty_table.
    " When
    FINAL(result) = m_cut->select_cds_entity( ).

    " Then
    cl_abap_unit_assert=>assert_initial( result ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_call_authority_check DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup                 RAISING cx_static_check.
    METHODS display_authorization FOR TESTING RAISING cx_static_check.
    METHODS edit_authorization    FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_call_authority_check IMPLEMENTATION.
  METHOD setup.
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD display_authorization.
    " Classic ABAP Authority Check Test Helper API
    " Given
    FINAL(develop_authorization) = VALUE cl_aunit_auth_check_types_def=>user_role_authorizations(
                                             ( role_authorizations = VALUE #(
                                                 ( object         = 'S_DEVELOP'
                                                   authorizations = VALUE #( ( VALUE #(
                                                       ( fieldname   = 'ACTVT'
                                                         fieldvalues = VALUE #( ( lower_value = '03' ) ) ) ) ) ) ) ) ) ).

    FINAL(authorization_object_set) = cl_aunit_authority_check=>create_auth_object_set( develop_authorization ).
    cl_aunit_authority_check=>get_controller( )->restrict_authorizations_to( authorization_object_set ).

    " When
    FINAL(result) = m_cut->call_authority_check( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 4 ).
  ENDMETHOD.

  METHOD edit_authorization.
    " Given
    FINAL(develop_authorization) = VALUE cl_aunit_auth_check_types_def=>user_role_authorizations(
                                             ( role_authorizations = VALUE #(
                                                 ( object         = 'S_DEVELOP'
                                                   authorizations = VALUE #( ( VALUE #(
                                                       ( fieldname   = 'ACTVT'
                                                         fieldvalues = VALUE #( ( lower_value = '02' ) ) ) ) ) ) ) ) ) ).

    FINAL(authorization_object_set) = cl_aunit_authority_check=>create_auth_object_set( develop_authorization ).
    cl_aunit_authority_check=>get_controller( )->restrict_authorizations_to( authorization_object_set ).

    " When
    FINAL(result) = m_cut->call_authority_check( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 0 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_fields_handler DEFINITION CREATE PUBLIC FOR TESTING.

  PUBLIC SECTION.
    INTERFACES if_botd_bufdbl_fields_handler.

  PRIVATE SECTION.
    DATA max_travel_id TYPE /dmo/travel_id VALUE 0.

ENDCLASS.

CLASS ltd_fields_handler IMPLEMENTATION.
  METHOD if_botd_bufdbl_fields_handler~set_readonly_fields.
    TYPES ty_create_instances TYPE TABLE FOR CREATE /dmo/i_travel_m.

    FIELD-SYMBOLS <create_instances> TYPE ty_create_instances.

    CASE entity_name.
      WHEN '/DMO/I_TRAVEL_M'.
        CASE operation.
          WHEN if_abap_behv=>op-m-create.
            ASSIGN instances TO <create_instances>.
            LOOP AT <create_instances> ASSIGNING FIELD-SYMBOL(<instance>).
              max_travel_id += 1.
              <instance>-travel_id = max_travel_id.
            ENDLOOP.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_call_rap_bo_tx_bf_dbl DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA g_rap_buffer_environment TYPE REF TO if_botd_txbufdbl_bo_test_env.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup.
    METHODS isolate_create_ba_to_pass FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_call_rap_bo_tx_bf_dbl IMPLEMENTATION.
  METHOD class_setup.
    FINAL(env_config) = cl_botd_txbufdbl_bo_test_env=>prepare_environment_config(
                            )->set_bdef_dependencies( VALUE #( ( '/DMO/I_TRAVEL_M' ) ) ).
    g_rap_buffer_environment = cl_botd_txbufdbl_bo_test_env=>create( env_config ).
  ENDMETHOD.

  METHOD class_teardown.
    g_rap_buffer_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    g_rap_buffer_environment->clear_doubles( ).
    FINAL(double) = g_rap_buffer_environment->get_test_double( '/DMO/I_TRAVEL_M' ).
    double->configure_additional_behavior( )->set_fields_handler( NEW ltd_fields_handler( ) ).

    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD isolate_create_ba_to_pass.
    " When
    m_cut->call_rap_business_object( IMPORTING e_reported = FINAL(reported)
                                               e_failed   = FINAL(failed)
                                               e_mapped   = FINAL(mapped) ).

    " Then
    cl_abap_unit_assert=>assert_initial( reported ).
    cl_abap_unit_assert=>assert_initial( failed ).
    cl_abap_unit_assert=>assert_not_initial( mapped ).
    cl_abap_unit_assert=>assert_initial( mapped-booking ).
    cl_abap_unit_assert=>assert_initial( mapped-booksuppl ).
    cl_abap_unit_assert=>assert_not_initial( mapped-travel ).
    cl_abap_unit_assert=>assert_equals( act = lines( mapped-travel ) exp = 1 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_call_rap_bo_mock_eml_api DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA g_mock_eml_api_environment TYPE REF TO if_botd_mockemlapi_bo_test_env.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    DATA m_cut TYPE REF TO zmsif_code_under_test.

    METHODS setup.
    METHODS isolate_create_ba_to_pass FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_call_rap_bo_mock_eml_api IMPLEMENTATION.
  METHOD class_setup.
    FINAL(env_config) = cl_botd_mockemlapi_bo_test_env=>prepare_environment_config(
                            )->set_bdef_dependencies( VALUE #( ( '/DMO/I_TRAVEL_M' ) ) ).
    g_mock_eml_api_environment = cl_botd_mockemlapi_bo_test_env=>create( env_config ).
  ENDMETHOD.

  METHOD class_teardown.
    g_mock_eml_api_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    g_mock_eml_api_environment->clear_doubles( ).
    m_cut = zmscl_factory=>get_code_under_test( ).
  ENDMETHOD.

  METHOD isolate_create_ba_to_pass.
    DATA mapped_double TYPE RESPONSE FOR MAPPED /DMO/I_Travel_M.

    " Given
    mapped_double-travel = VALUE #( ( %cid = 'Travel_1' travel_id = '1' ) ).
    FINAL(output_config_builder_4_modify) = cl_botd_mockemlapi_bldrfactory=>get_output_config_builder( )->for_modify( ).
    FINAL(output) = output_config_builder_4_modify->build_output_for_eml( )->set_mapped( mapped_double ).
    FINAL(double) = g_mock_eml_api_environment->get_test_double( '/DMO/I_TRAVEL_M' ).
    double->configure_call( )->for_modify( )->ignore_input( )->then_set_output( output ).

    " When
    m_cut->call_rap_business_object( IMPORTING e_reported = FINAL(reported)
                                               e_failed   = FINAL(failed)
                                               e_mapped   = FINAL(mapped) ).
    " Then
    cl_abap_unit_assert=>assert_initial( reported ).
    cl_abap_unit_assert=>assert_initial( failed ).
    cl_abap_unit_assert=>assert_not_initial( mapped ).
    cl_abap_unit_assert=>assert_initial( mapped-booking ).
    cl_abap_unit_assert=>assert_initial( mapped-booksuppl ).
    cl_abap_unit_assert=>assert_not_initial( mapped-travel ).
    cl_abap_unit_assert=>assert_equals( act = lines( mapped-travel ) exp = 1 ).
  ENDMETHOD.
ENDCLASS.

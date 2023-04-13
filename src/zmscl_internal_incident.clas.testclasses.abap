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
    " Given
    FINAL(mapped_double) = VALUE zmsif_code_under_test=>t_mapped( travel = VALUE #( ( %cid = 'Travel_1' ) ) ).
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

CLASS zmscl_internal_incident DEFINITION
  PUBLIC
  CREATE PRIVATE
  GLOBAL FRIENDS zmscl_factory.

  PUBLIC SECTION.
    INTERFACES zmsif_code_under_test.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.

CLASS zmscl_internal_incident IMPLEMENTATION.
  METHOD zmsif_code_under_test~call_other_object.
    FINAL(doc) = zmscl_factory=>get_depended_on_component( ).
    r_result = doc->add( i_summand_1 = 1
                         i_summand_2 = 2 ).
  ENDMETHOD.

  METHOD zmsif_code_under_test~call_function_module.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING text_question = 'Do you want this?'
      IMPORTING answer        = r_result.

    IF r_result = 'A'.
      r_result = 2.
    ENDIF.
  ENDMETHOD.

  METHOD zmsif_code_under_test~select_database_table.
    SELECT FROM demo_sales_so_i
           FIELDS parent_key AS SalesOrder, COUNT( so_item_key ) AS ItemCount
           GROUP BY parent_key
           INTO TABLE @r_result.
  ENDMETHOD.

  METHOD zmsif_code_under_test~select_cds_entity.
    SELECT FROM zms_cds_entity
           FIELDS SalesOrder, ItemCount
           INTO TABLE @r_result.
  ENDMETHOD.

  METHOD zmsif_code_under_test~call_authority_check.
    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
                    ID 'ACTVT' FIELD '02'.
    r_result = sy-subrc.
  ENDMETHOD.

  METHOD zmsif_code_under_test~call_rap_business_object.
    MODIFY ENTITIES OF /dmo/i_travel_m
           ENTITY travel
           CREATE FROM VALUE #( ( %cid                 = 'Travel_1'
                                  Agency_ID            = '000111'
                                  Customer_ID          = '000006'
                                  description          = 'Travel 1'
                                  %control-Agency_ID   = if_abap_behv=>mk-on
                                  %control-Customer_ID = if_abap_behv=>mk-on
                                  %control-description = if_abap_behv=>mk-on ) )
           REPORTED e_reported
           FAILED e_failed
           MAPPED e_mapped.
  ENDMETHOD.
ENDCLASS.

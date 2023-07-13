class zmscl_code_under_test definition
  public
  create private
  global friends zmscl_factory.

  public section.
    interfaces zmsif_code_under_test.

  protected section.

  private section.
endclass.


class zmscl_code_under_test implementation.
  method zmsif_code_under_test~call_other_object.
    final(doc) = zmscl_factory=>get_depended_on_component( ).
    r_result = doc->add( i_summand_1 = 1
                         i_summand_2 = 2 ).
  endmethod.

  method zmsif_code_under_test~call_function_module.
    call function 'POPUP_TO_CONFIRM'
      exporting text_question = 'Do you want this?'
      importing answer        = r_result.
  endmethod.

  method zmsif_code_under_test~select_database_table.
    select from demo_sales_so_i
           fields parent_key as SalesOrder, count( so_item_key ) as ItemCount
           group by parent_key
           into table @r_result.
  endmethod.

  method zmsif_code_under_test~select_cds_entity.
    select from zms_cds_entity
           fields SalesOrder, ItemCount
           into table @r_result.
  endmethod.

  method zmsif_code_under_test~call_authority_check.
    authority-check object 'S_DEVELOP'
                    id 'ACTVT' field '02'.
    r_result = sy-subrc.
  endmethod.

  method zmsif_code_under_test~call_rap_business_object.
    modify entities of /dmo/i_travel_m
           entity travel
           create from value #( ( %cid                 = 'Travel_1'
                                  Agency_ID            = '000111'
                                  Customer_ID          = '000006'
                                  description          = 'Travel 1'
                                  %control-Agency_ID   = if_abap_behv=>mk-on
                                  %control-Customer_ID = if_abap_behv=>mk-on
                                  %control-description = if_abap_behv=>mk-on ) )
           reported e_reported
           failed e_failed
           mapped e_mapped.
  endmethod.
endclass.

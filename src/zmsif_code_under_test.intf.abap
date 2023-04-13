INTERFACE zmsif_code_under_test PUBLIC.

  TYPES t_items_per_sales_order TYPE HASHED TABLE OF zms_cds_entity WITH UNIQUE KEY SalesOrder.
  TYPES t_failed   TYPE RESPONSE FOR FAILED /DMO/I_Travel_M.
  TYPES t_reported TYPE RESPONSE FOR REPORTED /DMO/I_Travel_M.
  TYPES t_mapped   TYPE RESPONSE FOR MAPPED /DMO/I_Travel_M.

  METHODS call_other_object     RETURNING VALUE(r_result) TYPE i.

  METHODS select_database_table RETURNING VALUE(r_result) TYPE t_items_per_sales_order.

  METHODS select_cds_entity     RETURNING VALUE(r_result) TYPE t_items_per_sales_order.

  METHODS call_function_module  RETURNING VALUE(r_result) TYPE char1.

  METHODS call_authority_check  RETURNING VALUE(r_result) TYPE i.

  METHODS call_rap_business_object EXPORTING e_reported TYPE t_reported
                                             e_failed   TYPE t_failed
                                             e_mapped   TYPE t_mapped.

ENDINTERFACE.

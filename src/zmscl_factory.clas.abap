CLASS zmscl_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zmsth_injector.

  PUBLIC SECTION.
    CLASS-METHODS
      get_code_under_test
        RETURNING VALUE(r_instance) TYPE REF TO zmsif_code_under_test.

    CLASS-METHODS
      get_depended_on_component
        RETURNING VALUE(r_instance) TYPE REF TO zmsif_depended_on_component.

  PRIVATE SECTION.
    CLASS-DATA g_code_under_test       TYPE REF TO zmsif_code_under_test.
    CLASS-DATA g_depended_on_component TYPE REF TO zmsif_depended_on_component.
ENDCLASS.



CLASS zmscl_factory IMPLEMENTATION.
  METHOD get_code_under_test.
    r_instance = COND #( WHEN g_code_under_test IS NOT BOUND THEN NEW zmscl_code_under_test( ) ELSE g_code_under_test ).
  ENDMETHOD.


  METHOD get_depended_on_component.
    r_instance = COND #( WHEN g_depended_on_component IS NOT BOUND
                         THEN NEW zmscl_depended_on_component( )
                         ELSE g_depended_on_component ).
  ENDMETHOD.
ENDCLASS.

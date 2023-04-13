CLASS zmsth_injector DEFINITION
  PUBLIC
  FINAL
  FOR TESTING
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS
      inject_code_under_test
        IMPORTING i_double TYPE REF TO zmsif_code_under_test.

    CLASS-METHODS
      inject_depended_on_component
        IMPORTING i_double TYPE REF TO zmsif_depended_on_component.

    CLASS-METHODS
      clear.
ENDCLASS.



CLASS zmsth_injector IMPLEMENTATION.
  METHOD clear.
    CLEAR zmscl_factory=>g_code_under_test.
    CLEAR zmscl_factory=>g_depended_on_component.
  ENDMETHOD.


  METHOD inject_code_under_test.
    zmscl_factory=>g_code_under_test = i_double.
  ENDMETHOD.


  METHOD inject_depended_on_component.
    zmscl_factory=>g_depended_on_component = i_double.
  ENDMETHOD.
ENDCLASS.

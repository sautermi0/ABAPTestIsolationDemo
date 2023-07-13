class zmsth_injector definition
  public
  final
  for testing
  create private.

  public section.
    class-methods
      inject_code_under_test
        importing i_double type ref to zmsif_code_under_test.

    class-methods
      inject_depended_on_component
        importing i_double type ref to zmsif_depended_on_component.

    class-methods
      clear.
endclass.


class zmsth_injector implementation.
  method clear.
    clear zmscl_factory=>g_code_under_test.
    clear zmscl_factory=>g_depended_on_component.
  endmethod.

  method inject_code_under_test.
    zmscl_factory=>g_code_under_test = i_double.
  endmethod.

  method inject_depended_on_component.
    zmscl_factory=>g_depended_on_component = i_double.
  endmethod.
endclass.

class zmscl_factory definition
  public
  final
  create private
  global friends zmsth_injector.

  public section.
    class-methods
      get_code_under_test
        returning value(r_instance) type ref to zmsif_code_under_test.

    class-methods
      get_depended_on_component
        returning value(r_instance) type ref to zmsif_depended_on_component.

  private section.
    class-data g_code_under_test       type ref to zmsif_code_under_test.
    class-data g_depended_on_component type ref to zmsif_depended_on_component.
endclass.


class zmscl_factory implementation.
  method get_code_under_test.
    r_instance = cond #( when g_code_under_test is not bound then new zmscl_code_under_test( ) else g_code_under_test ).
  endmethod.

  method get_depended_on_component.
    r_instance = cond #( when g_depended_on_component is not bound
                         then new zmscl_depended_on_component( )
                         else g_depended_on_component ).
  endmethod.
endclass.

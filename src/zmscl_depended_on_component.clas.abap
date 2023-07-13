class zmscl_depended_on_component definition
  public
  create private
  global friends zmscl_factory.

  public section.
    interfaces zmsif_depended_on_component.

  protected section.

  private section.

endclass.


class zmscl_depended_on_component implementation.
  method zmsif_depended_on_component~add.
    assert 1 = 0.
  endmethod.

  method zmsif_depended_on_component~subtract.
    r_difference = i_minuend - i_subtrahend.
  endmethod.
endclass.

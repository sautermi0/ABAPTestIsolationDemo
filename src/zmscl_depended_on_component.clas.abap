CLASS zmscl_depended_on_component DEFINITION
  PUBLIC
  CREATE PRIVATE
  GLOBAL FRIENDS zmscl_factory.

  PUBLIC SECTION.
    INTERFACES zmsif_depended_on_component.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zmscl_depended_on_component IMPLEMENTATION.
  METHOD zmsif_depended_on_component~add.
    ASSERT 1 = 0.
  ENDMETHOD.

  METHOD zmsif_depended_on_component~subtract.
    r_difference = i_minuend - i_subtrahend.
  ENDMETHOD.
ENDCLASS.

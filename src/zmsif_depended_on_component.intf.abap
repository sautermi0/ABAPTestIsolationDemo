INTERFACE zmsif_depended_on_component PUBLIC.

  METHODS add IMPORTING i_summand_1  TYPE i
                        i_summand_2  TYPE i
              RETURNING VALUE(r_sum) TYPE i.

  METHODS subtract IMPORTING i_minuend           TYPE i
                             i_subtrahend        TYPE i
                   RETURNING VALUE(r_difference) TYPE i.

ENDINTERFACE.

view: access_test {
#   derived_table: {
#     sql:
#          {% if _user_attributes['hakuhodo_filter'] == 'admin' %}
#
#         SELECT
#
#           '{{ _user_attributes['hakuhodo_filter'] }}' as brand
#
#          {% else %}
#
#         SELECT brand from demo_db2.products
#          {% endif %};;
#
#     }
derived_table: {
  sql:
        SELECT * from demo_db2.products;;

  }
  dimension: brand {
    type: string
    sql:　{% if _user_attributes['hakuhodo_filter'] == 'admin' %}
    '1'
    {% else %}
    ${TABLE}.brand
    {% endif %};;
#       sql:  ${TABLE}.brand;;
  }

}

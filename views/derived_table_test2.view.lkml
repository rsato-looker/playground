view: derived_table_test2 {

  derived_table: {
    sql:
        SELECT
          users.city  AS "city",
          COUNT(DISTINCT orders.id ) AS "count",
          orders.created_at as created_at
        FROM order_items  AS order_items
        LEFT JOIN orders  AS orders ON order_items.order_id = orders.id
        LEFT JOIN users  AS users ON orders.user_id = users.id
        where true
        {% if city_filter_1._is_filtered %}
        OR {% condition city_filter_1 %} city {% endcondition %}
　      {% endif %}
        GROUP BY 1
       ;;
#       sql: select * from order_items
#         {% condition city_filter_1 %} city {% endcondition %}
#         OR {% condition city_filter_2 %} city {% endcondition %}
#             where {% assign index = 1 %}
#                   {% condition city_filter_[index] %} city {% endcondition %};;
  }

#   derived_table: {
#     sql:
#         SELECT
#           users.city  AS "city",
#           COUNT(DISTINCT orders.id ) AS "count"
#         FROM order_items  AS order_items
#         LEFT JOIN orders  AS orders ON order_items.order_id = orders.id
#         LEFT JOIN users  AS users ON orders.user_id = users.id
#         where {% if _user_attributes['customvaluething2'] %} city="New York"
#         {% else %} city="California"
#         {% endif %}
#         GROUP BY 1
#        ;;
#   }

  filter: city_filter_1 {
    type: string
#     sql: {% condition city_filter_1 %}${city}{% endcondition %};;
    #suggest_explore: user -- no needed
    suggest_dimension: users.city
    #suggestions: ["Complete", "Pending", "Cancelled"] - doesn't work
  }

  filter: date {
    type: date
    convert_tz: no
#     sql: {% condition city_filter_1 %}${city}{% endcondition %};;
    #suggest_explore: user -- no needed
    #suggest_dimension: users.city
    #suggestions: ["Complete", "Pending", "Cancelled"] - doesn't work
  }

  filter: city_filter_2 {
    type: string
#     sql: {% condition city_filter_1 %}${city}{% endcondition %};;
    #suggest_explore: user -- no needed
    suggest_dimension: users.city
    #suggestions: ["Complete", "Pending", "Cancelled"] - doesn't work
  }

#    parameter: city_filter {
#     suggest_dimension: users.city
#    }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    #html: <a href="/dashboards/dashboardnumber?NameFilter={{ value }}&Filter2=filter_value">{{ value }}</a>  ;;
    #suggest_dimension: city
    #primary_key: yes
  }

  dimension_group: date {
    type: time
    timeframes: [date]
    sql: ${TABLE}.created_at ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.count ;;
  }

  measure: average_count_order {
    type: average
    sql: ${orders_count} ;;
    #drill_fields: [detail*]
  }
}

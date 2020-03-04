view: derived_table_test2 {
  derived_table: {
    sql:
        SELECT
          users.city  AS "city",
          COUNT(DISTINCT orders.id ) AS "count"
        FROM order_items  AS order_items
        LEFT JOIN orders  AS orders ON order_items.order_id = orders.id
        LEFT JOIN users  AS users ON orders.user_id = users.id
        where {% if _user_attributes['customvaluething2'] %} city="New York"
        {% else %} city="California"
        {% endif %}
        GROUP BY 1
       ;;
  }

#    filter: city_filter {
#      type: string
#       sql: {% condition city_filter %}${city}{% endcondition %};;
#       #suggest_explore: user -- no needed
#       suggest_dimension: users.city
#      #suggestions: ["Complete", "Pending", "Cancelled"] - doesn't work
#    }

    dimension: city {
      type: string
      sql: ${TABLE}.city ;;
      #html: <a href="/dashboards/dashboardnumber?NameFilter={{ value }}&Filter2=filter_value">{{ value }}</a>  ;;
      #suggest_dimension: city
      #primary_key: yes
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

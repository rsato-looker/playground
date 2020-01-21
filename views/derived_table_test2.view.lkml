view: derived_table_test2 {
  derived_table: {
    sql:
        SELECT
          users.city  AS "city",
          COUNT(DISTINCT orders.id ) AS "count"
        FROM order_items  AS order_items
        LEFT JOIN orders  AS orders ON order_items.order_id = orders.id
        LEFT JOIN users  AS users ON orders.user_id = users.id

        GROUP BY 1
       ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    primary_key: yes
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

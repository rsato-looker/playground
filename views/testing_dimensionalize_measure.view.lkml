view: testing_dimensionalize_measure {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
  products.brand  AS brand,
  products.id  AS id,
  COUNT(DISTINCT products.id ) AS products_count,
  COUNT(DISTINCT orders.id ) AS orders_count
FROM demo_db2.order_items  AS order_items
LEFT JOIN demo_db2.orders  AS orders ON order_items.order_id = orders.id
LEFT JOIN demo_db2.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
LEFT JOIN demo_db2.products  AS products ON inventory_items.product_id = products.id

WHERE
  (products.brand  IN ('Jobar', 'Beach Joy', 'CJ by Cookie Johnson'))
GROUP BY 1,2;;
  }

  # Define your dimensions and measures here, like this:
  dimension: brand {
    description: "Unique ID for each user that has ordered"
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }


  dimension: products_count {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.products_count ;;
  }

  dimension: orders_count {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.orders_count ;;
  }


  measure: count_id {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql_distinct_key: ${id} ;;
    sql: ${products_count} ;;
  }
}

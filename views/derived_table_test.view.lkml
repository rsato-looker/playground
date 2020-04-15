view: derived_table_test {
  derived_table: {
    sql: SELECT
        products.id  AS `products.id`,
        COALESCE(SUM(products.retail_price ), 0) AS `products.total`
      FROM demo_db2.products  AS products
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_id {
    type: number
    sql: ${TABLE}.`products.id` ;;
    primary_key: yes
  }

  dimension: products_total {
    type: number
    sql: ${TABLE}.`products.total` ;;
  }

  set: detail {
    fields: [products_id, products_total]
  }

  measure: avg_total {
    type: average
    sql: ${products_total} ;;
  }
}

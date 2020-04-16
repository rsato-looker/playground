view: derived_table_test {
  derived_table: {
    sql_trigger_value: SELECT now() from ${notpersisted.SQL_TABLE_NAME} ;;
    sql: SELECT
        products.id  AS `products.id`,
        COALESCE(SUM(products.retail_price ), 0) AS `products.total`
      FROM ${notpersisted.SQL_TABLE_NAME}  AS products
       ;;
    indexes: ["products.id"]
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

view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    label: "Inventory Item ID"
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count_new {
    type: count
    filters: {
       field: returned_year
       value: "2019"
    }
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: count_base {
    type: count
    html: <b>${{value}}</b> ;;
    filters: {
      field: returned_year
      value: "2018"
    }
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: sum {
    type: sum
    sql: ${sale_price} ;;
    html: {{ rendered_value }} || {{ order_id._rendered_value }} ;;
  }
}

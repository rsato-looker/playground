view: order_items {
  sql_table_name: demo_db2.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    #html: <font size="4">{{value}}</font> ;;
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
    html: {% if {{value}} > 5 and {{order_items.returend_month._value}} == 2016 }
          <font color="pink">{{value}}</font>
          {% else %}
          <font color="blue">{{value}}</font>
          {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}

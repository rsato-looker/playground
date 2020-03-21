view: order_items {
  #sql_table_name: demo_db2.order_items ;;
sql_table_name: demo_db2.order_items ;;

#   Dynamicly changing sql table
#   sql_table_name: demo_db{% parameter tablename %}.order_items ;;
#   drill_fields: [id]
#
#   parameter: tablename {
#     type: number
#   }

  dimension: id {
    primary_key: yes
    type: number
    html: <font size="1">{{value}}</font>;;
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
    #html: <font size="10">{{value}}</font>;;
    html: <p style="font-family:courier;">This is a paragraph.</p> ;;
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
      year,
      hour_of_day
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: today {
    type: date
    sql: CURDATE() ;;
    html: <a href="https://master.dev.looker.com/render/process/wd/1680/1/dashboards/3565.pdf?download=yes&filename=Test%20download%20{{value}}.pdf&title=Test%20download&longTables=false&pdf_paper_size=&pdf_landscape=false">Download</a> ;;
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
    link: {
      label: "desired label name"
      url: "{{ link }}&sorts=orders.id+desc"
    }
  }

  measure: agg_test {
    type: sum
    sql: ${sale_price} * ${orders.user_id} ;;
  }
}

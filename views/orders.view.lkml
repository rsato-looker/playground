view: orders {
  sql_table_name: demo_db2.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format: "*00#"
    html: <font size="3">{{rendered_value}}</font> ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      day_of_week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    html: <p style="color:blue">{{value}}</p> ;;
  }


  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: string
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Date' THEN ${orders.created_date}
    WHEN {% parameter timeframe_picker %} = 'Week' THEN ${orders.created_week}
    WHEN{% parameter timeframe_picker %} = 'Month' THEN ${orders.created_month}
    END ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: percent_of_total_order_count{
    type: percent_of_total
    value_format: "0.00"
    sql: ${count} ;;
  }

}

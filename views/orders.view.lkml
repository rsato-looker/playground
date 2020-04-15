view: orders {
  #sql_table_name: demo_db2.orders ;;
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format: "*00#"
    html: <font size="3">{{rendered_value}}</font> ;;
    hidden: yes
  }

  measure: XXX {
    type: number
    sql: ${status} + ${id} ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month_num,
      month_name,
      day_of_month,
      day_of_week,
      month,
      quarter,
      quarter_of_year,
      year
    ]
    sql: ${TABLE}.created_at ;;
    #html: <p style="color:blue">{{value}}</p> ;;
  }

  dimension_group: date {
    type: time
  }

  dimension: week {
    type: date_day_of_week
    sql: ${TABLE}.created_at ;;
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

  measure: count_com {
    type: count
    filters: {
      field: status
      value: "pending"
    }
  }

  measure: count_distinct_com {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: status
      value: "pending"
    }
  }

  measure: C{
    type: number
    sql: ${count_com} / ${count_distinct_com} ;;
    html: <a href="{{ C._link }}" target="_self"> {{rendered_value}} </a>;;
  }


  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    #html: <p style="color:blue">{{value}}</p> ;;
#     html: {% if created_day_of_week._value == "Sunday" %}
#       <p style="color:blue">{{value}}</p>
#       {% else %}
#       <p style=“color: black”>{{value}}</p>
#       {% endif %};;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
    html: {{rendered_value}} ;;
  }

  measure: percent_of_total_order_count{
    type: percent_of_total
    value_format: "0.00"
    sql: ${count} ;;
  }
}

view: orders {
  sql_table_name: demo_db2.orders ;;
  #sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  filter: previous_period_filter {
    type: date
    description: "Use this filter for period analysis"
    sql: ${previous_period} IS NOT NULL ;;
  }

  filter: date_filter {
    type: date
  }

  dimension: date_diff {
    type: duration_day
    sql_start: {% date_start date_filter %} ;;
    sql_end: {% date_end date_filter %} ;;
  }

  # For Amazon Redshift
  # ${created_raw} is the timestamp dimension we are building our reporting period off of
  dimension: previous_period {
    type: string
    description: "The reporting period as selected by the Previous Period Filter"
    sql:
      CASE
        WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is not null /* date ranges or in the past x days */
          THEN
            CASE
              WHEN ${created_raw} >=  {% date_start previous_period_filter %}
                AND ${created_raw} <= {% date_end previous_period_filter %}
                THEN 'This Period'
              WHEN ${created_raw} >= DATE_ADD(date,-1*DATEDIFF({% date_start previous_period_filter %}, {% date_end previous_period_filter %} ) + 1, DATE_ADD(date,-1,{% date_start previous_period_filter %} ) )
                AND ${created_raw} <= DATE_ADD(date, INTERVAL -1,{% date_start previous_period_filter %} )
                THEN 'Previous Period'
            END
          END ;;
  }

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

  parameter: admission_date_drill_down {
    type: unquoted
    allowed_value: {
      label: "Month"
      value: "admission_month"
    }
    allowed_value: {
      label: "Quarter"
      value: "admission_quarter"
    }
    allowed_value: {
      label: "Year"
      value: "admission_year"
    }
  }

#   dimension: report_by_admission_date {
#     sql: {% if admission_date_drill_down._parameter_value == 'admission_month' %}
#       ${created_month}
#       {% elsif admission_date_drill_down._parameter_value == 'admission_quarter' %}
#       CONCAT(${created_year}, "-", ${created_quarter_of_year})
#       {% elsif admission_date_drill_down._parameter_value == 'admission_year' %}
#       ${created_year}
#       {% else %}
#       ${created_date}
#       {% endif %};;
#   }

  dimension: month {
    type: date_month
    sql: ${created_month} ;;
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

  dimension: is_before_mtd {
    type: yesno
    sql: ( ${TABLE}.created_at not between DATE_FORMAT(NOW() ,'%Y-%M-01') AND NOW() ) ;;
  }
  dimension: is_before_ytd {
    type: yesno
    sql: ( ${TABLE}.created_at not between DATE_FORMAT(NOW() ,'%Y-01-01') AND NOW() ) ;;
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

  dimension: inbound {
    type: string
    sql: ${id};;
#     html: <div class="vis">
#    <div class="vis-single-value" style="font-size:80%; color:#FFFFFF; background-color:#5F9EA0">
#    <font color="#5A2FC2"><center><b>Inbound</b><p></p></font></div>
#    </div>      ;;
    html: <div class="vis" style="font-size:80%; color:#FFFFFF; background-color:#5F9EA0">
      <font color="#5A2FC2"><center><b>Inbound {{rendered_value}}</b><p></p></font></div>  ;;
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

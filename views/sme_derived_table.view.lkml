view: sme_derived_table {
  derived_table: {
    sql: SELECT
              country, created_at
              from demo_db2.users
              where {% condition date_filter %} created_at {% endcondition %}
              and country = '{% parameter country_param %}'
               ;;
  }

  filter: date_filter {
    type: date
    sql: {% condition date_filter %}${created_at_date}{% endcondition %};;
  }

  filter: country_filter {
    type: string
    suggest_dimension: country
  }

  parameter: country_param {
    type: unquoted
    allowed_value: {
      label: "United States"
      value: "USA"
    }
    allowed_value: {
      label: "Europe"
      value: "EU"
    }
  }

  dimension: formatted_time {
    type: date
    sql: ${created_at_date} ;;
    html:
      {% if country_param._parameter_value == 'USA' %}
        {{ rendered_value | date: "%m/%d/%Y" }}
      {% elsif country_param._parameter_value == 'EU' %}
        {{ rendered_value | date: "%d/%m/%Y" }}
      {% else %}
        <font color="darkred">{{ rendered_value }}</font>
      {% endif %}
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created_at {
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
    sql: ${TABLE}.created_at ;;
  }

  set: detail {
    fields: [country, created_at_time]
  }
}

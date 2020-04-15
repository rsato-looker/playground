view: users {
  sql_table_name: demo_db2.users ;;

  filter: state_filter {
    type: string
    suggest_dimension: state
  }

  filter: age_filter {
    type: number
  }

  parameter: filter_logic {
    type: unquoted
    allowed_value: {
      label: "OR"
      value: "OR"
    }
    allowed_value: {
      label: "AND"
      value: "AND"
    }
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "Drill by City dummy"
      #url: "/explore/rie_test/order_items?fields=users.city,users.state,users.count&sorts=users.city"
      url: "{{ dummy_link._link }}&sorts=users.age+desc"
    }
  }

  measure: dummy_link {
    type: number
    sql: 1=1 ;;
    drill_fields: [city,state,count,orders.count]
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  set: user_details {
    fields: [id, city, state, country]
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
  }

  dimension: for_vis {
    type: date_week
    sql: ${created_week} ;;
  }

  dimension: for_vis_2 {
    type: date_week
    sql: date_add(${created_week}, interval -1 day) ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    #hidden: yes
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_states {
    type: count_distinct
    sql: ${state} ;;
  }

  measure: percentage_states {
    type: number
    sql: ${count_states}/50 ;;
    #value_format_name: percent_0
    #value_format: "[>=100000]0.0,,\"M\";[>=1000]0.0,\"K\";[<1]0.0;0"
    #value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}

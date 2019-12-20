view: inventory_items {
  sql_table_name: demo_db2.inventory_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

   dimension: new_time_dimension {
     type: date_time
     sql: ${TABLE}.created_at ;;
   }

   dimension: from_duration {
    label: "Slot Start Time"
    type: string
    sql: DATE_FORMAT(to_date(${TABLE}.created_at/100 , 'HH24MI'), 'HH:MI PM') ;;
    order_by_field: new_time_dimension
  }


  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  dimension_group: duration {
    type: duration
    sql_start: ${created_date} ;;  # often this is a single database column
    sql_end: ${sold_date} ;;  # often this is a single database column
    intervals: [day] # valid intervals described
  }

  measure: count {
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count]
  }

  dimension: dashboard_link {
    type: string
    sql: 1 ;;
    html: <a href = "https://optimizely.looker.com/dashboards/378?State={{ _filters['users.state'] | url_encode }}&Age={{ _filters['users.age'] | url_encode }}"><font size="4"> Impressions/MUVs(Billing period)</font></a><br>
<a href = "https://optimizely.looker.com/dashboards/377?State={{ _filters['users.state'] | url_encode }}&Age={{ _filters['users.age'] | url_encode }}"><font size="4"> Experiment Impressions</font></a><br>
<a href = "https://optimizely.looker.com/dashboards/214?State={{ _filters['users.state'] | url_encode }}&Age={{ _filters['users.age'] | url_encode }}"><font size="4"> Benchmarks</font></a> ;;

  }
}

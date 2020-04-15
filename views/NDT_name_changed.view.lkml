# If necessary, uncomment the line below to include explore_source.
# include: "rie_test.model.lkml"

view: NDT_name_changed {
  derived_table: {
    explore_source: order_items {
      column: created_month { field: orders.created_month }
      column: count { field: orders.count }
      column: percent_of_total_order_count { field: orders.percent_of_total_order_count }
    }
  }
  dimension: created_month {
    type: date_month
  }
  dimension: count {
    type: number
  }
  dimension: percent_of_total_order_count {
    value_format: "0.00"
    type: number
  }
  measure: sum_total_percent {
    type: sum
    sql: ${percent_of_total_order_count} ;;
    value_format: "0.00"
  }
}

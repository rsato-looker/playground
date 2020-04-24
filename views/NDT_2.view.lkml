view: ndt_2 {
# If necessary, uncomment the line below to include explore_source.
# include: "rie_test.model.lkml"

    derived_table: {
      explore_source: order_items {
        column: created_month { field: orders.created_month }
        column: status { field: orders.status }
        column: count { field: orders.count }
#         bind_filters: {
#           to_field: order_items.created_month
#           from_field: ndt_2.created_month
#         }
      }
    }
#     dimension_group: created_month {
#       type: time
#       timeframes: [
#         date,
#         month
#       ]
#     }
    dimension: status {}
    measure: count {
      type: number
    }
  }

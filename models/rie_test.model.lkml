connection: "thelook"

# include all the views
include: "/views/**/*.view"
include: "/*.dashboard"

datagroup: rie_test_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rie_test_default_datagroup

explore: NDT_test {}

explore: calendar_table {}

explore: connection_reg_r3 {}

explore: epoch_test {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: ints {}

explore: inventory_items { hidden: yes}


explore: order_items {
  label: "order_items 😀"
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: derived_table_test {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${derived_table_test.products_id} ;;
    relationship: many_to_one
  }

  join: derived_table_test2 {
    type: left_outer
    sql_on: ${users.city} = ${derived_table_test2.city} ;;
    relationship: many_to_one
  }

  join: category_only_10 {
    type: left_outer
    sql_on: ${products.category} = ${category_only_10.category_10} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: persons {}

explore: products {}

explore: schema_migrations {}

explore: test_img {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

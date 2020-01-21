view: products {
  sql_table_name: demo_db2.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    #html: <b><a href="https://www.google.com/search?q={{value}}">{{ value }}</a></b> ;;
     link: {
       label: "Google brand name"
       url: "https://www.google.com/"
       icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
     }
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    html: {% if {{products.category._value}} == "Dresses" %}
          <font color="pink">{{value}}%</font>
          {% endif %};;
#     filters: {
#           field: brand
#           value: "-Speedo"
#     }
    drill_fields: [id, item_name, inventory_items.count]
  }

  measure: total {
    type: sum
    sql: ${retail_price} ;;
  }
  # if i do this way, drill down won't work
  measure: count_category {
    type: sum
    sql:
    case
    when ${category} like '%Sleep%Lounge%'
    then 1
    else 0
    end;;
  }
  # But in this way, drill down will work
  measure: count_category2 {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: category
      value: "%Pants%"
    }
    drill_fields: [category]
  }



}

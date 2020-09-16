view: adding_things {
  derived_table: {
    sql:
      SELECT
        customer_id,
        SUM(sale_price) AS lifetime_spend
      FROM
        order
      WHERE
        {% condition region %} order.region {% endcondition %}
      GROUP BY 1
    ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  }

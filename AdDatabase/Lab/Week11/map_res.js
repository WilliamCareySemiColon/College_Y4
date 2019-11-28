db = db.getSiblingDB('map_red_test')

db.orders.insert(
{
     cust_id: "abc123",
     ord_date: new Date("Oct 04, 2012"),
     status: 'A',
     price: 25,
     items: [ { item_name: "mmm", qty: 5, price: 2.5 },
              { item_name: "nnn", qty: 5, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "mary",
     ord_date: new Date("Mar 04, 2012"),
     status: 'A',
     price: 45,
     items: [ { item_name: "mmm", qty: 4, price: 2.5 },
			  { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "aaa", qty: 2, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "john",
     ord_date: new Date("Jan 04, 2012"),
     status: 'W',
     price: 35,
     items: [ { item_name: "mmm", qty: 4, price: 2.5 },
	          { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "laura",
     ord_date: new Date("Feb 04, 2012"),
     status: 'W',
     price: 15,
     items: [ { item_name: "kkk", qty: 40, price: 2.1 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "paul",
     ord_date: new Date("Oct 04, 2012"),
     status: 'A',
     price: 55,
     items: [ { item_name: "aaa", qty: 3, price: 2.5 },
              { item_name: "nnn", qty: 5, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "robert",
     ord_date: new Date("Mar 04, 2012"),
     status: 'A',
     price: 20,
     items: [ { item_name: "mmm", qty: 4, price: 2.5 },
	          { item_name: "bbb", qty: 4, price: 2.5 },
              { item_name: "aaa", qty: 2, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "jane",
     ord_date: new Date("Jul 04, 2012"),
     status: 'W',
     price: 35,
     items: [ { item_name: "aaa", qty: 6, price: 2.5 },
	          { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "mark",
     ord_date: new Date("Dec 04, 2012"),
     status: 'A',
     price: 15,
     items: [ { item_name: "kkk", qty: 40, price: 2.1 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});


db.orders.insert(
{
     cust_id: "abc123",
     ord_date: new Date("Oct 04, 2012"),
     status: 'A',
     price: 25,
     items: [ { item_name: "mmm", qty: 5, price: 2.5 },
              { item_name: "nnn", qty: 5, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "mary",
     ord_date: new Date("Mar 04, 2012"),
     status: 'A',
     price: 45,
     items: [ { item_name: "mmm", qty: 4, price: 2.5 },
	          { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "aaa", qty: 2, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "john",
     ord_date: new Date("Jan 04, 2012"),
     status: 'W',
     price: 35,
     items: [ { item_name: "mmm", qty: 4, price: 2.5 },
	          { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "laura",
     ord_date: new Date("Feb 04, 2012"),
     status: 'W',
     price: 15,
     items: [ { item_name: "kkk", qty: 40, price: 2.1 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "paul",
     ord_date: new Date("Oct 04, 2012"),
     status: 'A',
     price: 5,
     items: [ { item_name: "aaa", qty: 3, price: 2.5 },
              { item_name: "www", qty: 5, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "robert",
     ord_date: new Date("Mar 04, 2012"),
     status: 'A',
     price: 2,
     items: [ { item_name: "ccc", qty: 4, price: 2.5 },
	          { item_name: "bbb", qty: 4, price: 2.5 },
              { item_name: "aaa", qty: 2, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "jane",
     ord_date: new Date("Jul 04, 2012"),
     status: 'W',
     price: 15,
     items: [ { item_name: "aaa", qty: 6, price: 2.5 },
	          { item_name: "www", qty: 2, price: 2.5 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

db.orders.insert(
{
     cust_id: "mark",
     ord_date: new Date("Dec 04, 2012"),
     status: 'A',
     price: 135,
     items: [ { item_name: "kkk", qty: 40, price: 2.1 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});
				   
db.orders.insert(
{
     cust_id: "mark",
     ord_date: new Date("Dec 04, 2012"),
     status: 'A',
     price: 135,
     items: [ { item_name: "kkk", qty: 40, price: 2.1 },
              { item_name: "bbb", qty: 6, price: 2.5 } ]
});

				   
   
				   
//Example 2 - count, quantity and average price per product

var mapFunction2 = function() {
                       for (var idx = 0; idx < this.items.length; idx++) {
                           var key = this.items[idx].item_name;
                           var value = {
                                         price: this.items[idx].price,
                                         qty: this.items[idx].qty
                                       };
                           emit(key, value);
                       }
                    };
					
					
var reduceFunction2 = function(keyitem_name, countObjVals) {
                     reducedVal = { qty: 0, totalprice: 0 };

                     for (var idx = 0; idx < countObjVals.length; idx++) {
                         reducedVal.qty += countObjVals[idx].qty;
                         reducedVal.totalprice += countObjVals[idx].price * countObjVals[idx].qty;
                     }

                     return reducedVal;
                  };
				  
var finalizeFunction2 = function (key, reducedVal) {

                       reducedVal.avg = reducedVal.totalprice/reducedVal.qty;
                       return reducedVal;

                    };
					
db.orders.mapReduce( mapFunction2,
                     reduceFunction2,
                     {
                       out: { merge: "reduce_output" },
                       finalize: finalizeFunction2
                     }
                   )
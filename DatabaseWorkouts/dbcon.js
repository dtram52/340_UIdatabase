var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'mysql.eecs.oregonstate.edu',
  user            : 'cs290_tramd',
  password        : 'ticher52OSU',
  database        : 'cs290_tramd'
});

module.exports.pool = pool;
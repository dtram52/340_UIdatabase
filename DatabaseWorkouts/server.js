var express = require('express');
var mysql = require('./dbcon.js');
var app = express();
var handlebars = require("express-handlebars").create({defaultLayout: 'main'});
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));
app.engine("handlebars", handlebars.engine);
app.set("view engine", "handlebars");
app.set("port", 7677);

//route to homepage referenced from lecture
app.get('/', function(req, res, next) {
    var context = {};
    mysql.pool.query('SELECT * FROM workouts', function(err, rows, fields){
      if(err){
        next(err);
        return;
      }
      // formats rows for date. 
      //the toLocaleDateString() method converts the date of a Date object into a readable string
      for (var i = 0; i < rows.length; i++) {
        if (rows[i].date) {
		    rows[i].date = rows[i].date.toLocaleDateString();
        }
      }
      context.rowData = rows;
      res.render('home', context);
    });
});

//route to insert data ( from lecture)
app.get('/insert',function(req,res,next){
  var context = {};
  mysql.pool.query("INSERT INTO workouts SET ?",
	{name: req.query.n, reps: req.query.reps, weight: req.query.weight, date: req.query.date, lbs: req.query.lbs},
    function(err, result){
        if(err){
            next(err);
            return;
        }
	mysql.pool.query('SELECT * FROM workouts WHERE id = ' + result.insertId, function(err, rows, fields){
      	if(err){
        	next(err);
        	return;
      	}
        if (rows[0].date) {
		    rows[0].date = rows[0].date.toLocaleDateString();
	    }
        context.rowData = JSON.stringify(rows);
        res.type("text/plain");
        res.send(context.rowData);
   	});
  });
});
//post route which handles edits after they have been made
app.post('/',function(req,res,next){
  var context = {};
  mysql.pool.query("SELECT * FROM workouts WHERE id=?", [req.body.id], function(err, result){
    if(err){
      next(err);
      return;
    }
    if(result.length == 1){
      var vals = result[0];
      mysql.pool.query("UPDATE workouts SET name=?, reps=?, weight=?, date=?, lbs=? WHERE id=? ",
        [req.body.name || vals.name, req.body.reps || vals.reps, req.body.weight || vals.weight, req.body.date || vals.date, req.body.lbs || vals.lbs, req.body.id],
        function(err, result){
        if(err){
          next(err);
          return;
        }
        mysql.pool.query('SELECT * FROM workouts', function(err, rows, fields){
            if(err){
                next(err);
                return;
            }
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].date) {
                rows[i].date = rows[i].date.toLocaleDateString();
              }
            }
          context.rowData = rows;
          res.render('home', context);
        });
      });
    }
  });
});


//Edit route which will render edit page
app.get('/edit', function(req, res){
    var context = {};
  if(req.body){
    console.log(req.body);
  }
    mysql.pool.query('SELECT * FROM workouts WHERE id = ' + req.query.editId, function(err, rows, fields){
        if(err){
          next(err);
          return;
        }
        // date formatting
        if (rows[0].date) {
    var day = rows[0].date.getDate();
    var month = rows[0].date.getMonth();
    month++;
    var year = rows[0].date.getFullYear();
    var strDate = year + '-' + month + '-' + day;
        rows[0].date = strDate;
        }
        context.rowData = rows;
        res.render('edit', context);
    })
});

//Delete rows 
app.get('/delete',function(req,res,next){
  mysql.pool.query("DELETE FROM workouts WHERE id=?", [req.query.deleteId], function(err, result){
    if(err){
      next(err);
      return;
    }
    res.send(null);
  });
});

// reset table rom assignment description
app.get('/reset-table',function(req,res,next){
  var context = {};
  mysql.pool.query("DROP TABLE IF EXISTS workouts", function(err){ //replace your connection pool with the your variable containing the connection pool
    var createString = "CREATE TABLE workouts("+
    "id INT PRIMARY KEY AUTO_INCREMENT,"+
    "name VARCHAR(255) NOT NULL,"+
    "reps INT,"+
    "weight INT,"+
    "date DATE,"+
    "lbs BOOLEAN)";
    mysql.pool.query(createString, function(err){
      context.results = "Table reset";
      res.render('home',context);
    })
  });
});
app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.type('plain/text');
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Site has gone live on port ' + app.get('port'));
});
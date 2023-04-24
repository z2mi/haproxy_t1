import express from 'express' ;

const app = express();
const PORT = 3000;

let health_status = true



app.use(express.json());
app.use((err, req, res, next) => {
	console.error(err.message)
	res.status(500).send({code: 500, message: err.message})
})


app.post('/health', function(req, res) {
	if (req.body.health && req.body.health == true) {
		health_status = true ;
	} else {
		health_status = false ;
	}
	res.send({ health: health_status });

}) ;


app.get('/health', function (req, res) {
    if ( health_status ) { 
		res.status(200).send({ health: health_status });
	} else {
		res.status(500).send({ health: health_status }) ;
	}
}) ;

app.get('/', function (req, res) {
    res.send(req.headers);
})

app.get('/status', function(req, res) {
	res.send({platform: process.platform, arch: process.arch, cwd: process.cwd(), env: process.env});
}) ;


app.listen(PORT, function (err) {
	if (err) console.log(err);
	console.log("listening on PORT", PORT);
}) ;

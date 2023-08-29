import express from "express";
import crypto from "node:crypto"; // get random uuid 
import { fieldRouter } from "./routes/fields.js";
import { corsMiddleware } from "./middlewares/cors.js";


const app = express()
app.disable("x-powered-by") // disable the x-powered-by Express header
app.use(express.json()) // middleware to handle json request
app.use(corsMiddleware())

//App routes
app.use("/api/fields", fieldRouter)

// Home endpoint
app.get("/", (req, res) => {
    res.json({status: "Ok"})
})


const PORT = process.env.PORT ?? 8000

app.listen(PORT, () =>{
    console.log(`Server listening on port http://localhost:${PORT}`)
})
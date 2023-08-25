import express from "express";
import crypto from "node:crypto"; // get random uuid 
import { Prisma, PrismaClient } from "@prisma/client";
import { validateField } from "./validation-squemas/field.js";

const prisma = new PrismaClient()

const app = express()
app.use(express.json()) // middleware to handle json request
app.disable("x-powered-by") // disable the x-powered-by Express header

// Home endpoint
app.get("/", (req, res) => {
    res.json({status: "Ok"})
})

//Get all fields or by filter
app.get("/api/fields", async (req, res) => {
    const { deporte } = req.query
    if (deporte) {
        const field = await prisma.field.findMany({
            where: {deporte: deporte.toLocaleLowerCase()}
        })
        return res.status(200).json(field)
    }

    const field = await prisma.field.findMany()
    
    res.json(field)
})

//Get field by id
app.get("/api/fields/:id", async (req, res) => { // Path to regex
    const { id } = req.params;
    const parsedId = parseInt(id)

    const field = await prisma.field.findFirst({
        where: {id: parsedId},
    })

    if (field) return res.json(field)

    res.status(404).json({message: "Field Not found"})
});

app.post("/api/fields", async (req, res) => {

    const result = await validateField(req.body)
    const field = result.data
    

    if (result.error) {
        return res.status(400).json({error: JSON.parse(result.error.message)})
    }

    try {
        const newField = await prisma.field.create({
            data: {
                nombre: field.nombre,
                descripcion: field.descripcion,
                precio: field.precio,
                deporte: field.deporte
            }
        })

        res.status(201).json(newField)

    } catch (e) {
        if (e instanceof Prisma.PrismaClientKnownRequestError) {
            if (e.code === "P2002") {
                return res.status(400).json({error: "Error in the database"})
            }
        }
        throw e
    }
});

const PORT = process.env.PORT ?? 1234

app.listen(PORT, () =>{
    console.log(`Server listening on port http://localhost:${PORT}`)
})
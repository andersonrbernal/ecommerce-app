import express from 'express'
import mongoose from 'mongoose'
import Connection from './database/Connection.js'
import bodyParser from 'body-parser'
import cors from 'cors'
import userRoute from './routes/userRoute.js'
import authRoute from './routes/authRoute.js'
import cartRoute from './routes/cartRoute.js'
import purchaseRoute from './routes/purchaseRoute.js'
import { checkUser, requireAuth } from './libs/middlewares/authMiddleware.js'

const app = express()

mongoose.set('strictQuery', true)

const bodyParserConfig = { limit: '30mb', extended: true }
const publicFolder = express.static('public')

// Middleware
app.use(bodyParser.json(bodyParserConfig))
app.use(bodyParser.urlencoded(bodyParserConfig))
app.use(cors())
app.use(publicFolder)
mongoose.set('strictQuery', true)

// Connection
Connection.connect(app)

// Routes
app.use('/user', userRoute)
app.use('/auth', authRoute)
app.use('/cart', cartRoute)
app.use('/purchase', purchaseRoute)
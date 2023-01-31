import dotenv from 'dotenv'
import mongoose from 'mongoose'

dotenv.config()

class Connection {
    static connect(app) {
        try {
            mongoose.connect(process.env.DB_URI)
            app.listen(process.env.PORT)
        } catch (error) {
            console.log(error.message)
        }
    }
}

export default Connection
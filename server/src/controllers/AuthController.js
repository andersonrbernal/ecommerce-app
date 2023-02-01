import User from "../models/User.js"
import jwt from 'jsonwebtoken'
import { handleErrors } from "../libs/utilities/handleErrors.js"

async function createToken(id) {
    const token = jwt.sign({ id }, process.env.SECRET, { expiresIn: 259200000 });
    return token
}

class AuthController {
    static async register_user(req, res) {
        try {
            const user = await new User(req.body).save()
            const { password: userPassword, ...otherDetails } = user._doc

            const token = await createToken(user._doc._id)

            res.status(200).json({ success: true, token: token, data: otherDetails })
            return
        } catch (error) {
            res.status(400).json({ success: false, errors: handleErrors(error) })
            return
        }
    }

    static async login_user(req, res) {
        const { email, password } = req.body

        try {
            const user = await User.login(email, password)
            const { password: userPassword, ...otherDetails } = user._doc

            const token = await createToken(user._doc._id)


            res.status(200).json({ success: true, token: token, data: otherDetails })
            return
        } catch (error) {
            res.status(400).json({ success: false, errors: handleErrors(error) })
            return
        }
    }

    static async logout_user(req, res) {
        res.cookie('jwt', '', { maxAge: 1 })
        res.redirect('login')
    }
}

export default AuthController
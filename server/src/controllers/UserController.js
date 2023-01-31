import User from "../models/User.js"

class UserController {
    static async get_user(req, res) {
        const { id } = req.params

        try {
            const user = await User.findById(id)

            if (user) {
                const { password: userPassword, ...otherDetails } = user._doc
                res.status(200).json({ success: true, data: otherDetails })
                return
            }

        } catch (error) {
            res.status(404).json({ success: false, errors: { data: 'User not found.' } })
            return
        }
    }
}

export default UserController
import mongoose, { Schema } from "mongoose";
import bcrypt from 'bcrypt';
import validator from "validator";

function triggerUserAfter(doc, next) {
    console.log('New User Saved to Database.\n' + doc)
    next()
}

async function triggerUserBefore(next) {
    const salt = await bcrypt.genSalt();
    this.password = await bcrypt.hash(this.password, salt);
    next();
}


async function login(email, password) {
    const user = await this.findOne({ email });
    if (user) {
        const auth = await bcrypt.compare(password, user.password);
        if (auth) {
            return user;
        }
        throw Error("Incorrect password.");
    }
    throw Error("Incorrect email.");
}

const userStructure = {
    username: {
        type: String,
        required: [true, "Please, enter a username."],
        validate: [validator.isAlpha, "Please, enter a username with characters only."],
        minLength: [4, "The username should be at least 4 characters long."],
        maxLength: [255, "The username must not be over 255 characters long."],
    },
    email: {
        type: String,
        unique: true,
        required: [true, "Please enter an email."],
        validate: [validator.isEmail, 'Please, enter a valid email.'],
        maxLength: [255, "The email must not be over 255 characters long."],
        lowercase: true
    },
    password: {
        type: String,
        required: [true, "Please, enter a password."],
        minLength: [8, "The password must be at least 8 characters long."],
        maxLength: [255, "The password must not be over 255 characters long."]
    },
    cart: {
        type: Array,
        default: [],
    }
}

const opt = {
    timestamps: true
}

const userSchema = new Schema(userStructure, opt)
userSchema.statics.login = login;

// trigger before
userSchema.pre('save', triggerUserBefore);

// trigger after
userSchema.post('save', triggerUserAfter);

const User = mongoose.model('User', userSchema)

export default User
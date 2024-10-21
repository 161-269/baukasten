// @ts-check

// @ts-ignore
// ../build/dev/javascript/widgets/gleam.mjs
import { Ok, Error } from "./gleam.mjs";
// @ts-ignore
// ../build/dev/javascript/gleam_stdlib/gleam/option.mjs
import { Some, None } from "../gleam_stdlib/gleam/option.mjs";


/** @type {boolean} */
const isBrowser = !!(globalThis.window && window.document);

/**
 * @returns {boolean}
 */
export function inWebDevMode() {
    return isBrowser && !!document.getElementById("app-dev");
}

/**
 * @param {string} name 
 * @returns 
 */
export function hydrationState(name) {
    if (!isBrowser) return new Ok(new None());

    const element = document.getElementById(name);
    if (!element) return new Ok(new None());

    if (element.tagName.toLowerCase() !== "script") {
        return new Error(`Could not get hydration state: ` +
            `expected element with 'script' tag but got: ` +
            `'${element.tagName.toLowerCase()}'`);
    }

    if(!("type" in element) || typeof element.type !== "string") {
        return new Error(`Could not get hydration state: ` +
            `expected element with 'type' attribute set to: `+
            `'application/json'`);
    }

    if(element.type !== "application/json") {
        return new Error(`Could not get hydration state: ` +
            `expected element with 'type' attribute set to: `+
            `'application/json' but got: '${element.type}'`);
    }

    if(!("text" in element) || typeof element.text !== "string") {
        return new Error(`Could not get hydration state: ` +
            `expected element with 'text' attribute set to a string`);
    }

    const text = element.text.trim();
    if(text === "") {
        return new Ok(new None());
    }

    return new Ok(new Some(text));
}
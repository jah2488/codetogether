/// <reference types="react" />
declare const Input: ({ type, className, onChange, value, ...props }: {
    [x: string]: any;
    type?: string;
    className?: string;
    onChange: any;
    value: any;
}) => JSX.Element;
export default Input;

declare type ApiRequest = {
    headers: {
        [key: string]: string;
    };
    method: string;
    body?: any;
    data?: any;
    url: string;
};
export default class ApiClient {
    call(request: ApiRequest): Promise<Response>;
    get(url: string): Promise<Response>;
    put(url: string, data: any): Promise<Response>;
    post(url: string, data: any): Promise<Response>;
    delete(url: string): Promise<Response>;
}
export {};

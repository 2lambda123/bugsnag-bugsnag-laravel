<?php

namespace Bugsnag\BugsnagLaravel\Request;

use Bugsnag\Request\RequestInterface;
use Illuminate\Http\Request;

class LaravelRequest implements RequestInterface
{
    /**
     * The illuminate request instance.
     *
     * @var \Illuminate\Http\Request
     */
    protected $request;

    /**
     * Create a new laravel request instance.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return void
     */
    public function __construct(Request $request)
    {
        $this->request = $request;
    }

    /**
     * Are we currently processing a request?
     *
     * @return bool
     */
    public function isRequest()
    {
        return true;
    }

    /**
     * Get the session data.
     *
     * @return array
     */
    public function getSession()
    {
        $session = $this->request->getSession();

        return $session ? $session->all() : [];
    }

    /**
     * Get the cookies.
     *
     * @return array
     */
    public function getCookies()
    {
        return $this->request->cookies->all();
    }

    /**
     * Get the request formatted as meta data.
     *
     * @return array
     */
    public function getMetaData()
    {
        $data = [];

        $data['url'] = $this->request->fullUrl();

        $data['httpMethod'] = $this->request->getMethod();

        $data['params'] = $this->request->input();

        $data['clientIp'] = $this->getRequestIp();

        if ($agent = $this->request->header('User-Agent')) {
            $data['userAgent'] = $agent;
        }

        if ($headers = $this->request->headers->all()) {
            $data['headers'] = $headers;
        }

        return ['request' => $data];
    }

    /**
     * Get the request context.
     *
     * @return string|null
     */
    public function getContext()
    {
        return $this->request->getMethod().' '.$this->request->getPathInfo();
    }

    /**
     * Get the request user id.
     *
     * @return string|null
     */
    public function getUserId()
    {
        return $this->request->getClientIp();
    }

    /**
     * Get the request ip.
     *
     * @return string|null
     */
    protected function getRequestIp()
    {
        if ($ip = $this->request->header('X-Forwarded-For')) {
            return $ip;
        }
        
        return $this->request->getClientIp();
    }
}

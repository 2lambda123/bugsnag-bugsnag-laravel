<?php

namespace App\Http\Controllers;

use Bugsnag\BugsnagLaravel\Facades\Bugsnag;
use Exception;
use Illuminate\Routing\Controller as BaseController;

class TestController extends BaseController
{
    public function unhandledException()
    {
        throw new Exception('Crashing exception!');
    }

    public function unhandledError()
    {
        foo();
    }

    public function handledException()
    {
        Bugsnag::notifyException(new Exception('Handled exception'));

        return 'done';
    }

    public function handledError()
    {
        Bugsnag::notifyError('Handled error', 'This is a handled error');

        return 'done';
    }
}

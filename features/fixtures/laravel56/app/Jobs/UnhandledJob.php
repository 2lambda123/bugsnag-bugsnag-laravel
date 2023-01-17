<?php

namespace App\Jobs;

use RuntimeException;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Bugsnag\BugsnagLaravel\Facades\Bugsnag;

class UnhandledJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        Bugsnag::leaveBreadcrumb(__METHOD__);

        throw new RuntimeException('uh oh :o');
    }
}

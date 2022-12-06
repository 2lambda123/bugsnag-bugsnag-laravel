<?php

namespace App\Jobs;

use App\Jobs\Job;
use RuntimeException;
use Illuminate\Contracts\Bus\SelfHandling;
use Illuminate\Contracts\Queue\ShouldQueue;

class UnhandledJob extends Job implements SelfHandling, ShouldQueue
{
    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        throw new RuntimeException('uh oh :o');
    }
}

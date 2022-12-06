<?php

namespace App\Jobs;

use RuntimeException;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

class UnhandledJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries;

    public function __construct(int $tries)
    {
        $this->tries = $tries;
    }

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

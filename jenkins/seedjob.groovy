pipelineJob('weatherapp') {
     definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/roceb/sampleeksjenkins.git')
                    }
                branch('main')
                }
            }

        }
    }
}
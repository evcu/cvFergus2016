local M = {}

function M.parse(arg)
    local cmd = torch.CmdLine();
    cmd:text()
    cmd:text('The German Traffic Sign Recognition Benchmark: A multi-class classification ')
    cmd:text()
    cmd:text('Options:')
    cmd:option('-data',             '',             'Path to dataset')
    cmd:option('-resample',         'false',        'Path to dataset')
    cmd:option('-val',              0.1,             'Percentage to use for validation set')
    cmd:option('-nEpochs',          300,            'Maximum epochs')
    cmd:option('-batchsize',        128,            'Batch size for epochs')
    cmd:option('-nThrLoad',         1,              'Number of dataloading threads')
    cmd:option('-nThr',         16,              'Number of processing threads')
    cmd:option('-manualSeed',       '0',            'Manual seed for RNG')
    cmd:option('-LR',               0.1,            'initial learning rate')
    cmd:option('-LRD',              0.00001,            'initial learning rate')
    cmd:option('-momentum',         0.9,            'momentum')
    cmd:option('-logDir',           'logs',         'log directory')
    cmd:option('-model',            '',             'Model to use for training')
    cmd:option('-pre',            'basic32',             'Dataset generation')
    cmd:option('-jobID',            'sub0',             'Dataset generation')
    cmd:option('-verbose',          'false',        'Print stats for every batch')
    --[[
    -- Hint: Use this option to convert your code to use GPUs
    --]]
    -- cmd:option('-cuda',            '',             'Use cuda tensor')

    local opt = cmd:parse(arg or {})

    if opt.model == '' or not paths.filep('models/'..opt.model..'.lua') then
        cmd:error('Invalid model ' .. opt.model)
    end

    if opt.pre == '' or not paths.filep('prepro/'..opt.pre..'.lua') then
        cmd:error('Invalid preprocessing file ' .. opt.pre)
    end

    return opt
end

return M

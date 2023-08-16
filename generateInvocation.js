const generateUtil = require('eth-delegatable-utils').generateUtil;

const ownerPrivateKey = 'xxx';

const yourAddr = '0x02588c713A565a9626d84813DC271b1008001Dcf';

const BASE_AUTH =
  '0x0000000000000000000000000000000000000000000000000000000000000000';

const contractAddr = '0x27e8cBA14010e413944E057D3A0327a20b22F99F';

const CONTRACT_INFO = {
  chainId: 59140,
  verifyingContract: contractAddr,
  name: 'AllowList',
};
const delegatableUtils = generateUtil(CONTRACT_INFO);

function generateDelegation(pk, to, caveats = Array(), authority = BASE_AUTH) {
  const DELEGATION = {
    delegate: to,
    authority: authority,
    caveats: caveats,
  };
  const signedDelegation = delegatableUtils.signDelegation(DELEGATION, pk);

  return signedDelegation;
}

const _delegation = generateDelegation(
  ownerPrivateKey,
  '0x02588c713A565a9626d84813DC271b1008001Dcf'
);

console.log('_delegation: ', _delegation);

const INVOCATION_MESSAGE = {
  replayProtection: {
    nonce: '0x01',
    queue: '0x00',
  },
  batch: [
    {
      authority: [_delegation],
      transaction: {
        to: contractAddr,
        gasLimit: '21000000000000',
        data: '0x3b7fa354000000000000000000000000ad90e5b7c7802084867849a0c24276ee47f89151',
      },
    },
  ],
};

console.log('INVOCATION_MESSAGE: ', JSON.stringify(INVOCATION_MESSAGE));

const invocation = delegatableUtils.signInvocation(
  INVOCATION_MESSAGE.batch[0],
  ownerPrivateKey
);
console.log('invocation: ', JSON.stringify(invocation));

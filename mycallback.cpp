#include "mycallback.h"
#include "sbs2datahandler.h"

MyCallback::MyCallback(QObject *parent) :
    Sbs2Callback(parent)
{
}

void MyCallback::getData(Sbs2Packet *packet)
{
    setPacket(packet);

    sbs2DataHandler->record();

    if (!(thisPacket->cq == -1))
	   emit cqValues(thisPacket->cqName,thisPacket->cq);


    int packetInRecording = (currentPacket - sbs2DataHandler->getPacketZero() +1);
    if (packetInRecording%4 == 0)
	emit currentPacketInRecording(packetInRecording);

}

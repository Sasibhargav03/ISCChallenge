/**
 * @description A simple Pub/Sub pattern implementation
 */
public with sharing class PubSubService {
    IHandleMessages incoming;
    private PubSubService() { }
    
    /**
     * @description A singleton for service interaction.
     */
    public static PubSubService Instance {
        get {
            if (Instance == null) {
                Instance = new PubSubService();
            }

            return Instance;
        }

        private set;
    }

    /**
     * @description Subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void subscribe(IHandleMessages implementation) {
		 if (implementation == null) throw new ArgumentNullException();
        		incoming = implementation;
            
			// if incoming is not on the subscribed list, add it to the list.
			
    
    }

    /**
     * @description Un-subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void unsubscribe(IHandleMessages implementation) {
		if (implementation == null) throw new ArgumentNullException();
        if(incoming == implementation){
            incoming = null;
        }

            // if tobeRemoved is already on the subscribed list, remove it from the list
    
    }

    /**
     * @description Emits a message to a given channel containing the specified data.
     * @param channel The channel to emit a message on.
     * @param data The data to emit.
     * @throws ArgumentNullException if channel is null.
     */
    public void emit(String channel, Object data) {
		 if (string.IsEmpty(channel)) throw new ArgumentNullException();

            if (data == null) throw new ArgumentNullException();
        if(incoming==Null){
            return;
        }
        if(channel == 'IncomingLeads'){
            /*IncomingLeadHandler IncomingLeadHandlerObj = new IncomingLeadHandler();
            IncomingLeadHandlerObj.handleMessage(channel,data);*/
            IHandleMessages instance = (IHandleMessages)Type.forName('IncomingLeadHandler').newInstance();
            instance.handleMessage(channel,data);
        }else if(channel == 'IncomingContacts'){
            IHandleMessages instance = (IHandleMessages)Type.forName('PubSubServiceTest.IncomingContactHandler').newInstance();
            instance.handleMessage(channel,data);        
        }
    }
}